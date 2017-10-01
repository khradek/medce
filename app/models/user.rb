class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :masqueradable

  mount_uploader :image, ImageUploader
  
  validates_processing_of :image
  validate :password_complexity, :image_size_validation
  

  has_many :courses     #as author
  #has_many :evaluations #as author
  has_many :purchased_courses, dependent: :destroy
   
  def password_complexity
    if password.present? and not password.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)./)
      errors.add :password, "must include at least one lowercase letter, one uppercase letter, and one digit"
    end
  end

  def fullname
    fullname = "#{first_name} #{last_name}"
  end

  private
  def image_size_validation
    errors[:image] << "should be less than 500KB" if image.size > 0.5.megabytes
  end

end
