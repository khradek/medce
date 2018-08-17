Stripe.api_key = STRIPE_SECRET


class RecordCharges
  def call(event)
    charge = event.data.object

    # Look up the user in our database
    user = User.find_by(stripe_id: charge.customer)
    
    # Record a charge in our database
    c = user.charges.where(stripe_id: charge.id).first_or_create
    c.update(
      amount: charge.amount,
      card_last4: charge.source.last4,
      card_brand: charge.source.brand,
      card_exp_month: charge.source.exp_month,
      card_exp_year: charge.source.exp_year,
      charge_date: Time.at(charge.created)
    )

    # Update user subscription_end by 1.months if not user's first charge
    if user.charges.count > 1 
      sub_end_date = user.subscription_end
      user.update(subscription_end: sub_end_date + 1.month)
    end
    
  end
end


StripeEvent.configure do |events|
  events.subscribe 'charge.succeeded', RecordCharges.new
end