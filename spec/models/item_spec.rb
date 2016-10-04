require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "Validations" do
    it "requires a name" do
      i = Item.new
      i.valid?
      expect(i.errors).to have_key(:name)
    end

  end
end
