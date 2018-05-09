class EmailSubscribersController < ApplicationController
  before_action :set_email_subscriber, only: [:show, :edit, :update, :destroy]
  before_filter :authorize_admin, only: [:index, :show, :update, :destroy, :edit, :new]
  invisible_captcha only: [:create]

  # GET /email_subscribers
  # GET /email_subscribers.json
  def index
    @email_subscribers = EmailSubscriber.all
  end

  # GET /email_subscribers/1
  # GET /email_subscribers/1.json
  def show
  end

  # GET /email_subscribers/new
  def new
    @email_subscriber = EmailSubscriber.new
  end

  # GET /email_subscribers/1/edit
  def edit
  end

  # POST /email_subscribers
  # POST /email_subscribers.json
  def create
    @email_subscriber = EmailSubscriber.new(email_subscriber_params)

    respond_to do |format|
      if @email_subscriber.save
        format.js
        format.html { redirect_to @email_subscriber, notice: 'Email subscriber was successfully created.' }
        format.json { render :show, status: :created, location: @email_subscriber }

      else
        format.html { render :new }
        format.json { render json: @email_subscriber.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /email_subscribers/1
  # PATCH/PUT /email_subscribers/1.json
  def update
    respond_to do |format|
      if @email_subscriber.update(email_subscriber_params)
        format.html { redirect_to @email_subscriber, notice: 'Email subscriber was successfully updated.' }
        format.json { render :show, status: :ok, location: @email_subscriber }
      else
        format.html { render :edit }
        format.json { render json: @email_subscriber.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /email_subscribers/1
  # DELETE /email_subscribers/1.json
  def destroy
    @email_subscriber.destroy
    respond_to do |format|
      format.html { redirect_to email_subscribers_url, notice: 'Email subscriber was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_email_subscriber
      @email_subscriber = EmailSubscriber.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def email_subscriber_params
      params.require(:email_subscriber).permit(:email)
    end
end
