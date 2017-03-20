class AddStripeCustomerTokenToUsers < ActiveRecord::Migration[5.0]
  def change
    # Add customer token field to users table
    add_column :users, :stripe_customer_token, :string
  end
end
