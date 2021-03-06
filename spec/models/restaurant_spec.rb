require 'spec_helper'

describe Restaurant, type: :model do

  it { is_expected.to have_many(:reviews).dependent(:destroy) }

  it { is_expected.to belong_to(:user) }

  it 'is not valid with a name of less than three characters' do
    restaurant = Restaurant.new(name: "kf")
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it 'is not valid unless it has a unique name' do
    Restaurant.create(name: "Moe's Tavern")
    restaurant = Restaurant.new(name: "Moe's Tavern")
    expect(restaurant).to have(1).error_on(:name)
  end

  it 'knows if it has previously been reviewed by a certain user' do
    user = double(:user, id: 1)
    restaurant = Restaurant.create(name: "Pizza Hut")
    restaurant.reviews.create(user_id: 1)
    expect(restaurant.has_been_reviewed_by(user)).to equal(true)
  end

  it 'knows if it has not previously been reviewed by a certain user' do
    user = double(:user, id: 2)
    restaurant = Restaurant.create(name: "Pizza Hut")
    restaurant.reviews.create(user_id: 1)
    expect(restaurant.has_been_reviewed_by(user)).to equal(false)
  end

end
