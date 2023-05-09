require "rails_helper"

RSpec.describe "playing a game" do
  let!(:room) { create :room }
  let!(:die) { create :die, game: room.game }
  let!(:face) { create :face, die: die }
  let!(:resource) { create :resource, game: room.game }
  let!(:global_resource) { create :resource, game: room.game, global: true }

  it "allows the player to play a game once they have joined" do
    login_user room.created_by

    expect(page).to have_text("Welcome")

    visit room_play_path(room)

    expect(page).to have_text("Playing #{room.game.name}")
    expect(page).to have_text("#{resource.name}\n0")
    expect(page).to have_text(die.name)

    click_link resource.name
    fill_in "Amount", with: 2
    click_button "Save"

    expect(page).to have_text("#{resource.name}\n2")

    click_button id: "die-button-#{die.id}"
    click_on "5"

    expect(page).to have_text(face.name)
    expect(page).to have_text("#{face.name}: 5")
  end

  describe "turbo stream features" do
    let(:first_player) { create :user }
    let(:second_player) { create :user }

    before do
      room.users << first_player
      room.users << second_player
      using_session "first" do
        login_user first_player

        visit room_play_path(room)
      end

      using_session "second" do
        login_user second_player

        visit room_play_path(room)
      end
    end

    it "allows the users to see eachothers rolls" do
      using_session "first" do
        click_button id: "die-button-#{die.id}"
        click_on "5"
        expect(page).to have_text("#{first_player.username} rolled #{face.name}: 5")
      end

      using_session "second" do
        expect(page).to have_text("#{first_player.username} rolled #{face.name}: 5")

        click_button id: "die-button-#{die.id}"
        click_on "3"

        expect(page).to have_text("#{second_player.username} rolled #{face.name}: 3")
      end

      using_session "first" do
        expect(page).to have_text("#{second_player.username} rolled #{face.name}: 3")

        all('button[aria-label="Close"]').each(&:click)

        expect(page).not_to have_text("#{first_player.username} rolled #{face.name}: 5")
        expect(page).not_to have_text("#{second_player.username} rolled #{face.name}: 3")

        click_button "Roll Log"

        expect(page).to have_text("#{first_player.username} rolled #{face.name}: 5")
        expect(page).to have_text("#{second_player.username} rolled #{face.name}: 3")

        find('#dice-rolls-drawer button[aria-controls="dice-rolls-drawer"]').click

        expect(page).not_to have_text("#{first_player.username} rolled #{face.name}: 5")
        expect(page).not_to have_text("#{second_player.username} rolled #{face.name}: 3")
      end
    end

    it "allows users to see eachothers resources" do
      using_session "first" do
        click_link resource.name
        fill_in "Amount", with: 2
        click_button "Save"

        expect(page).to have_text("#{resource.name}\n2")
      end

      using_session "second" do
        click_button "Other Player's Resources"

        expect(page).to have_text first_player.username
        expect(page).to have_text "#{resource.name}\n2"
      end

      using_session "first" do
        click_link resource.name
        fill_in "Amount", with: 3
        click_button "Save"
      end

      using_session "second" do
        expect(page).to have_text "#{resource.name}\n3"
      end
    end

    it "allows users to each update global resources" do
      using_session "first" do
        click_link global_resource.name
        fill_in "Amount", with: 2
        click_button "Save"

        expect(page).to have_text("#{global_resource.name}\n2")
      end

      using_session "second" do
        click_link global_resource.name
        fill_in "Amount", with: 4
        click_button "Save"

        expect(page).to have_text("#{global_resource.name}\n4")
      end

      using_session "first" do
        expect(page).to have_text("#{global_resource.name}\n4")
      end
    end
  end
end
