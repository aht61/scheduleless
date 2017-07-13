class Registration
  include ActiveModel::Model

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, length: { minimum: 3, maximum: 200 }
  validate :email_unique?
  validates :password, presence: true
  validates_format_of :password,
    with: /\A(?=.*[a-zA-Z])(?=.*[0-9]).{8,}\z/,
    message: "must include one number, one letter and be between 8 and 40 characters"

  attr_accessor :email, :first_name, :last_name, :password

  def company
    user.company
  end

  def register
    if user.persisted?
      begin
        if Rails.application.secrets.deliver_support_mailers
          SupportMailer.new_signup(user).deliver
        end
      rescue StandardError => error
        Bugsnag.notify(error)
        Bugsnag.notify("New Sign Up - Support Email Failed To Send")
      end
    end

    user
  end

  def user
    @_user ||= create_user
  end

  private

  def create_payment_account
    customer.
      subscriptions.
      create(plan: company.subscription.plan)

    customer
  end

  def create_user
    user = User.create(user_params)
    user
  end

  def customer
    @_customer ||= Stripe::Customer.create(
      description: company.name
    )
  end

  def email_unique?
    if User.where(email: email).present?
      errors.add(:email, I18n.t("onboarding.registrations.model.email_taken"))
    end
  end

  def user_params
    {
      company_admin: true,
      email: email,
      family_name: last_name,
      given_name: first_name,
      password: password,
      password_confirmation: password,
      company_attributes: {
        name: "Company Name" # we want to make sure a company is created for them here
      }
    }
  end
end
