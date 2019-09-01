class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :images

  PHONE_NUMBER_REGEX = /^05\d{2}\d{3}\d{4}/m
  IMAGE_REGEX = /^image\/(jpeg|pjpeg|gif|png|bmp)$/
  validates_presence_of :header
  validates_presence_of :content
  validates_presence_of :name
  validates_presence_of :location
  validates_presence_of :phone_number
  validates_presence_of :images

  validate :is_image
  validate :image_limit
  validates_length_of :header,:maximum => 64
  validates_length_of :content,:maximum => 512
  validates_length_of :name,:maximum => 21
  validates_length_of :location,:maximum => 21
  validates_length_of :phone_number, :maximum => 12
  validates_format_of :phone_number, :with => PHONE_NUMBER_REGEX, :multiline => true
  validates_uniqueness_of :phone_number

  scope :visible, lambda {where(:visible => true)}
  scope :invisible, lambda {where(:visible => false)}
  scope :sorted, lambda {order(:position => :asc)}
  scope :popular_first, lambda {order(:visitor_count => :desc)}
  scope :newest_first, lambda {order(:created_at => :desc)}
  scope :search, lambda {|query| where(["name LIKE ?", "%#{query}%"])}

  def is_image
    images.each do |image|
      unless image and image.content_type =~ IMAGE_REGEX
        errors.add(:images, "Not a valid image(s)")
        image.purge
      end
    end
  end

  def image_limit
    if images.size > 6
      errors.add(:images,"Max image limit is 5")
      images.each do |image|
        image.purge
      end
    #elsif images.size == 0
    #  errors.add(:images,"no image found")
    end
  end

end
