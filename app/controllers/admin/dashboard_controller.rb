class Admin::DashboardController < AdminController
  def show
    @product_count ||= Product.count()
    @category_count ||= Category.count()
  end
end
