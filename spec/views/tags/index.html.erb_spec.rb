require 'rails_helper'

RSpec.describe "tags/index", type: :view do
  before do
    create(:tag, name: 'Chicken')
    create(:tag, name: 'Beef')
    assign(:tags, Tag.all)
  end

  it "renders a list of tags" do
    render
    expect(rendered).to match /Chicken/
    expect(rendered).to match /Beef/
  end
end
