json.extract! med_prof, :id, :title, :about, :med_prof_type, :latitude, :longitude, :user_id, :created_at, :updated_at
json.url med_prof_url(med_prof, format: :json)
