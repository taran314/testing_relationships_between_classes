# Simo's tests from mocking workshop

RSpec.describe SecretDiary do
 context "when locked" do
   it "refuses to be read" do
     # Arrange
     # Our doubles can be called anything we want
     foo = double(:my_notebook)
     secret_diary = SecretDiary.new(foo)
     secret_diary.lock
     # Assert
     expect(foo).not_to receive(:read)
     # Act + Assert
     expect(secret_diary.read).to eq("Go away!")
   end
   it "refuses to be written" do
     # Arrange
     foo = double(:my_notebook)
     secret_diary = SecretDiary.new(foo)
     secret_diary.lock
     # Assert
     expect(foo).not_to receive(:write)
     # Act + Assert
     expect(secret_diary.write("I don't like animals")).to eq("Go away!")
   end
 end
 context "when unlocked" do
   it "gets read" do
     # Arrange
     notebook_double = double(:my_notebook, :read => "my secret") # This is a shorthand for stubbing methods
     secret_diary = SecretDiary.new(notebook_double)
     secret_diary.unlock
     # Below is another way to stub a method on a double
     # allow(notebook_double).to receive(:read).and_return("my secret")
     # Act + Assert
     expect(secret_diary.read).to eq("my secret")
   end
   it "gets read with spies" do
     # Arrange
     foo = spy(:my_notebook)
     secret_diary = SecretDiary.new(foo)
     secret_diary.unlock
     # Act
     secret_diary.read
     # Assert
     # Using spies, we can wait until the end of the test to assert which methods were called
     # (note that "have_received" is in the past tense).
     expect(foo).to have_received(:read)
   end
   it "gets written" do
     diary_double = double(:my_diary)
     diary_entry = "Some days I don't brush my teeth"
     secret_diary = SecretDiary.new(diary_double)
     secret_diary.unlock
     # We can also specify that we want a method to be called with certain arguments.
     expect(diary_double).to receive(:write).with(diary_entry)
     secret_diary.write(diary_entry)
   end
 end
end