class MedProf < ApplicationRecord
  belongs_to :user, dependent: :destroy
  geocoded_by :address
  after_create :set_slug
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }
  after_update :update_slug, if: ->(obj){ obj.slug.present? and obj.title_changed? }

  searchkick locations: [:location]

  mount_uploader :image, ImageUploader

  def set_slug
    slug = self.id.to_s + "-" + self.title.parameterize.truncate(80, omission: '').remove(".")
    self.update(slug: slug)
  end

  def to_param
    slug
  end

  def title_changed
    title_changed?
  end
  
  def update_slug
    slug = self.slug
    new_slug = self.id.to_s + "-" + self.title.parameterize.truncate(80, omission: '').remove(".")
    unless new_slug == slug 
      self.update(slug: new_slug)
    end
  end

  def address
    [street, city, state, zip].compact.join(", ")
  end

  def address_changed?
    street_changed? || city_changed? || state_changed? || zip_changed?
  end

  def search_data
    attributes.merge location: { lat: latitude, lon: longitude }
  end

  STATES =
    [
      ['AK', 'AK'],
      ['AL', 'AL'],
      ['AR', 'AR'],
      ['AZ', 'AZ'],
      ['CA', 'CA'],
      ['CO', 'CO'],
      ['CT', 'CT'],
      ['DC', 'DC'],
      ['DE', 'DE'],
      ['FL', 'FL'],
      ['GA', 'GA'],
      ['HI', 'HI'],
      ['IA', 'IA'],
      ['ID', 'ID'],
      ['IL', 'IL'],
      ['IN', 'IN'],
      ['KS', 'KS'],
      ['KY', 'KY'],
      ['LA', 'LA'],
      ['MA', 'MA'],
      ['MD', 'MD'],
      ['ME', 'ME'],
      ['MI', 'MI'],
      ['MN', 'MN'],
      ['MO', 'MO'],
      ['MS', 'MS'],
      ['MT', 'MT'],
      ['NC', 'NC'],
      ['ND', 'ND'],
      ['NE', 'NE'],
      ['NH', 'NH'],
      ['NJ', 'NJ'],
      ['NM', 'NM'],
      ['NV', 'NV'],
      ['NY', 'NY'],
      ['OH', 'OH'],
      ['OK', 'OK'],
      ['OR', 'OR'],
      ['PA', 'PA'],
      ['RI', 'RI'],
      ['SC', 'SC'],
      ['SD', 'SD'],
      ['TN', 'TN'],
      ['TX', 'TX'],
      ['UT', 'UT'],
      ['VA', 'VA'],
      ['VT', 'VT'],
      ['WA', 'WA'],
      ['WI', 'WI'],
      ['WV', 'WV'],
      ['WY', 'WY']
    ]
  


end
