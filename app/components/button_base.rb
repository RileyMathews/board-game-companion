module ButtonBase
  VARIANT_TO_CLASS_COLOR_MAP = {
    default: "text-white bg-blue-700 hover:bg-blue-800 focus:ring-blue-300 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800", # rubocop:disable Layout/LineLength
    light: "text-gray-900 bg-white border border-gray-300 focus:outline-none hover:bg-gray-100 focus:ring-gray-200 dark:bg-gray-800 dark:text-white dark:border-gray-600 dark:hover:bg-gray-700 dark:hover:border-gray-600 dark:focus:ring-gray-700", # rubocop:disable Layout/LineLength
    danger: "text-white bg-red-700 hover:bg-red-800 focus:ring-red-300 dark:bg-red-600 dark:hover:bg-red-700 dark:focus:ring-red-900" # rubocop:disable Layout/LineLength
  }.freeze

  def full_class_list
    "#{base_classes} #{color_classes}"
  end

  def base_classes
    "text-sm focus:ring-4 font-medium rounded-lg px-5 py-2.5 mr-2 mb-2 focus:outline-none"
  end

  def color_classes
    VARIANT_TO_CLASS_COLOR_MAP[@variant]
  end
end