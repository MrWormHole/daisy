class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :images

  PHONE_NUMBER_REGEX = /^05\d{2}\d{3}\d{4}/m
  IMAGE_REGEX = /^image\/(jpeg|pjpeg|gif|png|bmp)$/
  validates_presence_of :header, :message => "Yohooo"
  validates_presence_of :content, :message => "Yohooo"
  validates_presence_of :name, :message => "Yohooo"
  validates_presence_of :location, :message => "Yohooo"
  validates_presence_of :phone_number, :message => "Yohooo"

  validate :is_image
  validates_length_of :header,:maximum => 64, :message => "Kohooo"
  validates_length_of :content,:maximum => 512, :message => "Kohooo"
  validates_length_of :name,:maximum => 21, :message => "Kohooo"
  validates_length_of :location,:maximum => 21, :message => "Kohooo"
  validates_length_of :phone_number, :maximum => 12, :message => "Kohooo"
  validates_format_of :phone_number, :with => PHONE_NUMBER_REGEX, :multiline => true, :message => "Lohooo"
  validates_uniqueness_of :phone_number, :message => "Johooo"

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

end
