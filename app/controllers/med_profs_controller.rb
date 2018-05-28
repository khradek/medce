class MedProfsController < ApplicationController
  before_action :set_med_prof, only: [:show, :edit, :update, :destroy]

  def index
    @med_profs = if params[:l] && params[:med_prof_type]
                   sw_lat, sw_lng, ne_lat, ne_lng = params[:l].split(",")
                   MedProf.search("*", page: params[:page], per_page: 5, 
                                        where: {
                                          location: {
                                            top_left: {
                                              lat: ne_lat,
                                              lon: sw_lng
                                            },
                                            bottom_right: {
                                              lat: sw_lat,
                                              lon: ne_lng
                                            }
                                          },
                                        med_prof_type: params[:med_prof_type]  
                                        })                                        
                  elsif params[:l]
                   sw_lat, sw_lng, ne_lat, ne_lng = params[:l].split(",")
                   MedProf.search("*", page: params[:page], per_page: 5, where: {
                                          location: {
                                            top_left: {
                                              lat: ne_lat,
                                              lon: sw_lng
                                            },
                                            bottom_right: {
                                              lat: sw_lat,
                                              lon: ne_lng
                                            }
                                          }
                                        })
                 elsif params[:near] && params[:med_prof_type]
                   location = Geocoder.search(params[:near]).first
                   MedProf.search "*", page: params[:page], per_page: 5,
                    boost_by_distance: {location: {origin: {lat: location.latitude, lon: location.longitude}}},
                    where: {
                      location: {
                        near: {
                          lat: location.latitude,
                          lon: location.longitude
                        },
                        within: "25mi"
                      },
                      med_prof_type: params[:med_prof_type]  
                    }
                 elsif params[:near] 
                   location = Geocoder.search(params[:near]).first
                   MedProf.search "*", page: params[:page], per_page: 5,
                    boost_by_distance: {location: {origin: {lat: location.latitude, lon: location.longitude}}},
                    where: {
                      location: {
                        near: {
                          lat: location.latitude,
                          lon: location.longitude
                        },
                        within: "25mi"
                      } 
                    } 
                 elsif params[:med_prof_type]
                   MedProf.search("*", page: params[:page], per_page: 5, 
                                        where: {
                                        med_prof_type: params[:med_prof_type]  
                                        })                          
                 else
                  MedProf.all.order("state").paginate(:page => params[:page], :per_page => 5)
                end
    @p_location = params[:near]
    @type_filter = params[:med_prof_type]
  end




  def show
    @med_profs = ["", MedProf.find(params[:id])]
  end

  def new
    @med_prof = MedProf.new
  end

  def edit
  end

  def create
    @med_prof = MedProf.new(med_prof_params)

    respond_to do |format|
      if @med_prof.save
        format.html { redirect_to @med_prof, notice: 'Your listing was successfully created.' }
        format.json { render :show, status: :created, location: @med_prof }
      else
        format.html { render :new }
        format.json { render json: @med_prof.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @med_prof.update(med_prof_params)
        format.html { redirect_to @med_prof, notice: 'Your listing was successfully updated.' }
        format.json { render :show, status: :ok, location: @med_prof }
      else
        format.html { render :edit }
        format.json { render json: @med_prof.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @med_prof.destroy
    respond_to do |format|
      format.html { redirect_to med_profs_url, notice: 'Your listing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_med_prof
      @med_prof = MedProf.find(params[:id])
    end

    def med_prof_params
      params.require(:med_prof).permit(:title, :about, :med_prof_type, :image, :phone, :street, :city, :zip, :state, :latitude, :longitude, :user_id)
    end
end
