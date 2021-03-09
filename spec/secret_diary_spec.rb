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
  let(:diary) { SecretDiary.new("Hi") }
  context "when locked" do
    it "refuses to be read" do
      expect(diary.read).to eq("Go away!")
    end

    it "refuses to be written" do
      # meant to double the message?
      expect(diary.write("Hi")).to eq("Go away!")
    end
  end

  context "when unlocked" do
    before do
      diary.instance_variable_set(:@unlocked, true)
    end
    it "gets read" do
      expect(diary.read)
    end

    pending "gets written"
    # expect a change within diary
  end
end

# write and read seem recursive in nature? - @diary does not have a @diary
