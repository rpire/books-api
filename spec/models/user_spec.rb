require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    User.new(
      name: 'Average HP Fan',
      bio: 'I love fantasy books!',
      icon: 7,
      email: 'hp_fan@email.com',
      password: 'expeliarmus'
    )
  end

  before { subject.save }

  describe 'Initial test' do
    it 'is valid from the beginning' do
      expect(subject).to be_valid
    end
  end

  describe 'Tests for "name"' do
    it 'checks the presense' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'checks the length' do
      subject.name = 'Ok... I don\'t think that many people out there have names as long as this sentence'
      expect(subject).to_not be_valid
    end
  end

  describe 'Tests for "bio"' do
    it 'checks the length' do
      subject.bio = 'this will be a really long bio...' * 8
      expect(subject).to_not be_valid
    end
  end

  describe 'Tests for "icon"' do
    it 'checks the presence' do
      subject.icon = nil
      expect(subject).to_not be_valid
    end

    it 'checks the numericality' do
      subject.icon = 'seven'
      expect(subject).to_not be_valid
    end

    it 'checks if integer' do
      subject.icon = 7.4
      expect(subject).to_not be_valid
    end

    it 'checks if greater or equal to 0' do
      subject.icon = 0
      expect(subject).to be_valid

      subject.icon = -1
      expect(subject).to_not be_valid
    end

    it 'checks if less or equal to 9' do
      subject.icon = 9
      expect(subject).to be_valid

      subject.icon = 10
      expect(subject).to_not be_valid
    end
  end
end
