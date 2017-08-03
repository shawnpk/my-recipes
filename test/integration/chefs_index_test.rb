require 'test_helper'

class ChefsIndexTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname: 'shawn', email: 'shawn@example.com',
                         password: 'password', password_confirmation: 'password')
    @chef2 = Chef.create!(chefname: 'ethan', email: 'ethan@example.com',
                         password: 'password', password_confirmation: 'password')
  end
  
  test 'should get chefs listing' do
    get chefs_path
    assert_template 'chefs/index'
    assert_select 'a[href=?]', chef_path(@chef), text: 'Shawn'
    assert_select 'a[href=?]', chef_path(@chef2), text: 'Ethan'
  end
end
