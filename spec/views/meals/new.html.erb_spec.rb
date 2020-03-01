require 'rails_helper'

RSpec.describe "meals/new", type: :view do
  before do
    sign_in create(:user)
    @meal = assign(:meal, create(:meal, name: 'Pizza'))
  end

  it "renders new meal form" do
    render
    assert_select "form[action=?][method=?]", meal_path(@meal), "post" do
      assert_select "input[name=?]", "meal[name]"
    end
  end

  it "does not render global check box" do
    render
    expect(rendered).not_to match /global_meal/
  end

  context "logged in as admin" do
    let(:meal) { create(:meal, name: 'Pizza') }
    before do
      sign_in create(:user, :admin)
    end

    it "does render global check box" do
      render
      expect(rendered).to match /global_meal/
    end
  end
end
