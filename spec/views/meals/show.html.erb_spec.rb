require 'rails_helper'

RSpec.describe "meals/show", type: :view do
  before(:each) do
    @meal = assign(:meal, create(:meal, name: 'Pizza'))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Pizza/)
  end
end
