class SubscriptionsController < ApplicationController
  before_action :authenticate_user!, except: [:new]
  before_action :redirect_to_signup, only: [:new]

  def create
    customer = if current_user.stripe_id?
                Stripe::Customer.retrieve(current_user.stripe_id)
               else
                Stripe::Customer.create(email: current_user.email)
               end

    subscription = customer.subscriptions.create(
      source: params[:stripeToken],
      plan: "plan_D2RIyw07lEEyt5"
    )

    options = {
      stripe_id: customer.id,
      stripe_subscription_id: subscription.id,
      subscription_end: Time.at(subscription.current_period_end),
      cancelled: false,
    }

    # Only update the card on file if we're adding a new one
    options.merge!(
      card_last4: params[:card_last4],
      card_exp_month: params[:card_exp_month],
      card_exp_year: params[:card_exp_year],
      card_brand: params[:card_brand]
    ) if params[:card_last4]

    current_user.update(options)

    #Updates each med_prof belonging to user to active 
    current_user.med_profs.each do |med_prof|
      med_prof.update(active: true)
    end

    redirect_to home_path, notice: "Your listing is now active and can be edited in your account settings" 
  end


  #don't show listing if cancelled true and subscription_end in the past
  #only show listing if cancelled false and subscription_end in the future... need to worry about if both nill
  #med_prof scope: active => where med_prof.user cancelled = true & subscriptin_end.past?
  def destroy
    customer = Stripe::Customer.retrieve(current_user.stripe_id)  
    customer.subscriptions.retrieve(current_user.stripe_subscription_id).delete
    current_user.update(cancelled: true)

    #end_date = current_user.subscription_end
    #current_user.med_profs.update(cancelled: true, subscription_end: end_date)

    redirect_to root_path, notice: "Your listing has been deactivated"
  end

  private

  def redirect_to_signup
    if !user_signed_in?
      session["user_return_to"] = new_subscription_path
      redirect_to new_user_registration_path
    end
  end

end