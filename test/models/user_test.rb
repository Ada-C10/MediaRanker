require "test_helper"

describe User do

  # it "is valid when all fields are present" do
  #   describe 'validations' do
  #     before do
  #       # Arrange
  #       author = Author.new(name: 'test author')
  #       @book = Book.new(title: 'test book', author: author)
  #     end
  #     value(user).must_be :valid
  #   end

  it 'is an invalid username name blank' do
    user = users(:blank)
    expect(user.valid?).must_equal false
  end

  it "is an valid username" do
    user = users(:jazz)
    expect(user.valid?).must_equal true
  end

  it 'is an invalid length for a username' do
    user = users(:tierney)
    expect(user.valid?).must_equal false
  end

  it 'is an invalid username duplicate' do
    user = users(:jazz)
    user = User.new(username: "jazztaz")
    expect(user.valid?).must_equal false
  end


  # describe 'relations' do
  #   it 'can set the user through "user"' do
  #     # Create two models
  #     user = User.create!(username: "blackngreen")
  #     work = Work.new(title: "new work")
  #
  #     # Make the models relate to one another
  #     User.work = author
  #
  #     # author_id should have changed accordingly
  #     expect(book.author_id).must_equal author.id
  #     expect(@book.errors.messages).must_include :title
  #   end
  #
  #   it 'can set the author through "author_id"' do
  #     # Create two models
  #     author = Author.create!(name: "test author")
  #     book = Book.new(title: "test book")
  #
  #     # Make the models relate to one another
  #     book.author_id = author.id
  #
  #     # author should have changed accordingly
  #     expect(book.author).must_equal author
  #     expect(@book.errors.messages).must_include :title
  #   end
  # end
  #
  # describe 'validations' do
  #   before do
  #     # Arrange
  #     author = Author.new(username: 'test author')
  #     @book = Book.new(title: 'test book', author: author)
  #     expect(@book.errors.messages).must_include :title
  #   end
  #
  #   it 'is valid when all fields are present' do
  #     # Act
  #     result = @book.valid?
  #
  #     # Assert
  #     expect(result).must_equal true
  #     expect(@book.errors.messages).must_include :title
  #   end
  #
  #   it 'is invalid without a title' do
  #     # Arrange
  #     @book.title = nil
  #
  #     # Act
  #     result = @book.valid?
  #
  #     # Assert
  #     expect(result).must_equal false
  #     expect(@book.errors.messages).must_include :title
  #   end
  # end

end
