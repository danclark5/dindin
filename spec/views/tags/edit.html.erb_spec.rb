require 'rails_helper'

RSpec.describe "tags/edit", type: :view do
  before do
    @tag = assign(:tag, create(:tag, name: 'Beef'))
  end

  it "renders new tag form" do
    render
    assert_select "form[action=?][method=?]", tag_path(@tag), "post" do
      assert_select "input[name=?]", "tag[name]"
    end
  end
end
