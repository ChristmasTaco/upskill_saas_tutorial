class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  belongs_to :plan
  
  has_one :profile
  
  # Make the stripe_card_token available as an attribute
  attr_accessor :stripe_card_token
  # Creating function to be called in registrations_controller for Pro users
  def save_with_subscription
    #If user data passes validations, then call Stripe with user information
    #to get a new subscription created upon charging their card
    if valid?
      customer = Stripe::Customer.create(description: email, plan: plan_id, card: stripe_card_token)
      self.stripe_customer_token = customer.id
      save!
    end
  end
end
