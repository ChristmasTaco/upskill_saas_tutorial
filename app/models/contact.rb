class Contact < ActiveRecord::Base
    #  'validates' allows for us to set certain parameters as required using the 'presence' value
     validates :name, presence: true
     validates :email, presence: true
     validates :comments, presence: true
end