require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname: 'shawn', email: 'shawn@example.com',
                         password: 'password', password_confirmation: 'password')
    @chef2 = Chef.create!(chefname: 'ethan', email: 'ethan@example.com',
                         password: 'password', password_confirmation: 'password')
    @admin_chef = Chef.create!(chefname: 'alyssa', email: 'alyssamk@ineptsoftware.com',
                         password: 'password', password_confirmation: 'password', admin: true)
  end

  test 'reject an invalid edit' do
    sign_in_as(@chef, 'password')
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chefname: '', email: 'shawn@example.com' } }
    assert_template 'chefs/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  test 'accept valid edit' do
    sign_in_as(@chef, 'password')
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chefname: 'shawnk', email: 'shawnk@example.com' } }
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match 'shawnk', @chef.chefname
    assert_match 'shawnk@example.com', @chef.email
  end

  test 'accept edit attempt by admin chef' do
    sign_in_as(@admin_chef, 'password')
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chefname: 'shawnpk', email: 'shawnpk@example.com' } }
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match 'shawnpk', @chef.chefname
    assert_match 'shawnpk@example.com', @chef.email
  end

  test 'redirect edit attempt by a non-admin chef' do
    sign_in_as(@chef2, 'password')
    updated_name = 'joe'
    updated_email = 'joe@example.com'
    patch chef_path(@chef), params: { chef: { chefname: updated_name, email: updated_email } }
    assert_redirected_to chefs_path
    assert_not flash.empty?
    @chef.reload
    assert_match 'shawn', @chef.chefname
    assert_match 'shawn@example.com', @chef.email
  end
end
