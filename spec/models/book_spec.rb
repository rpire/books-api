require 'rails_helper'

RSpec.describe Book, type: :model do
  before :all do
    @user = User.create(
      name: 'Average HP Fan',
      bio: 'I love fantasy books!',
      icon: 7,
      email: 'hp_fan@email.com',
      password: 'expeliarmus'
    )
  end

  after :all do
    @user.destroy
  end

  subject do
    Book.new(
      user_id: @user.id,
      title: 'Harry Potter and the Philosopher\'s Stone',
      author: 'J.K. Rowling',
      category: 'Fantasy Novel',
      current_chapter: 'Diagon Alley',
      num_of_pages: 254,
      current_page: 77
    )
  end

  before { subject.save }

  describe 'Initial test' do
    it 'is valid from the beginning' do
      expect(subject).to be_valid
    end
  end

  describe 'Tests for "title"' do
    it 'checks the presence' do
      subject.title = nil
      expect(subject).to_not be_valid
    end
  end

  describe 'Tests for "author"' do
    it 'checks the presence' do
      subject.author = nil
      expect(subject).to_not be_valid
    end

    it 'checks the length' do
      subject.author = 'But seriouly speaking... how long can the name of the author of a book be?'
      expect(subject).to_not be_valid
    end
  end

  describe 'Tests for "current_chapter"' do
    it 'checks the presence' do
      subject.current_chapter = nil
      expect(subject).to_not be_valid
    end

    it 'checks the length' do
      subject.current_chapter = 'And now again... how long can the name of a chapter be?'
      expect(subject).to_not be_valid
    end
  end

  describe 'Tests for "num_of_pages"' do
    it 'checks the presence' do
      subject.num_of_pages = nil
      expect(subject).to_not be_valid
    end

    it 'checks the numericality' do
      subject.num_of_pages = 'two hundred fifty four'
      expect(subject).to_not be_valid
    end

    it 'checks if integer' do
      subject.num_of_pages = 254.3
      expect(subject).to_not be_valid
    end

    it 'checks if greater than 0' do
      subject.num_of_pages = 0
      expect(subject).to_not be_valid
      subject.num_of_pages = -1
      expect(subject).to_not be_valid
    end
  end

  describe 'Tests for "current_page"' do
    it 'checks the presence' do
      subject.current_page = nil
      expect(subject).to_not be_valid
    end

    it 'checks the numericality' do
      subject.current_page = 'seventy_seven'
      expect(subject).to_not be_valid
    end

    it 'checks if integer' do
      subject.current_page = 77.7
      expect(subject).to_not be_valid
    end

    it 'checks if greater or equal to 0' do
      subject.current_page = 0
      expect(subject).to be_valid
      subject.current_page = -1
      expect(subject).to_not be_valid
    end

    it 'checks if less or equal to "num_of_pages"' do
      subject.current_page = 255
      expect(subject).to_not be_valid
    end
  end

  describe 'Tests for "category"' do
    it 'checks the presence' do
      subject.category = nil
      expect(subject).to_not be_valid
    end

    it 'checks the length' do
      subject.category = 'Once again... how long could a books category name possibly be?'
      expect(subject).to_not be_valid
    end
  end
end
