require 'rails_helper'

RSpec.describe "meals/index", type: :view do
  before do
    sign_in create(:user)
    assign(:meals, [
      create(:meal, name: 'Pasta'),
      create(:meal, name: 'Pizza')
    ])
  end

  it "renders a list of meals" do
    render
    expect(rendered).to match /Pasta/
    expect(rendered).to match /Pizza/
  end

  it "doesn't show link to edit or destroy the meals" do
    render
    expect(rendered).not_to match /Edit/
    expect(rendered).not_to match /Destroy/
  end

  context "as an admin" do
    before do
      sign_in create(:user, :admin)
    end
    it "shows edit and delete" do
      render
      expect(rendered).to match /Edit/
      expect(rendered).to match /Destroy/
    end
  end
end
