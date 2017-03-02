class Admin::DashboardController < Admin::BaseController
  before_action :authenticate_user!
  before_action :authorize
  def index
    @product_count = Product.count
    @review_count = Review.count
    @user_count = User.count
  end


end
