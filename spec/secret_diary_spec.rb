require_relative '../lib/secret_diary'

### WARNING ###
# For the purposes of this exercise, you are testing after
# the code has been written. This means your tests are prone
# to false positives!
#
# Make sure your tests work by deleting the bodies of the
# methods in `secret_diary.rb`, like this:
#
# ```ruby
# def write(new_message)
# end
# ```
#
# If they fail, then you know your tests are working
# as expected.
### WARNING ###

RSpec.describe SecretDiary do
  
  context "when locked" do
    it "refuses to be read" do
      # Arrange
      # Our doubles can be called anything we want
      foo = double(:my_notebook)
      diary = SecretDiary.new(foo)
      diary.lock
      # Assert
      expect(foo).not_to receive(:read)
      # Act + Assert
      expect(diary.read).to eq("Go away!")
    end

    it "refuses to be written" do
      # Arrange
      foo = double(:notebook)
      diary = SecretDiary.new(foo)
      diary.lock
      # Assert
      expect(foo).not_to receive(:write)
      # Act + Assert
      expect(diary.write("Hi there")).to eq("Go away!")
    end
  end
  
  context "when unlocked" do
    it "gets read" do
      notebook_double = double(:notebook, read: "my secret")
      secret_diary = SecretDiary.new(notebook_double)
      secret_diary.unlock

      # Method stub - when use allow ---- same as setting up as above
      # allow(secret_diary). to receive(:read).and_return("my secret")
      expect(secret_diary.read).to eq("my secret")

      # Some people like doing it like this:
      # Arrange
      foo = spy(:notebook)
      diary = SecretDiary.new(foo)
      diary.unlock
      # Act
      diary.read
      # Assert ---- received happened in the past (spying on method calls)
      expect(foo).to have_received(:read)
    end

    it "gets written" do
      notebook_double = double(:notebook)
      secret_diary = SecretDiary.new(notebook_double)
      diary_entry = "Hi there"
      secret_diary.unlock

      # We can also specify that we want a method to be called with certain arguments.
      expect(notebook_double).to receive(:write).with(diary_entry)

      secret_diary.write(diary_entry)

    end
  end
end
