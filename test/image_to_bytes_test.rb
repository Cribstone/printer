require "test_helper"

describe Jobs::ImageToBytes do
  describe "encoding data" do
    subject do
      Jobs::ImageToBytes.encoded_image(fixture_path("8x8.png"))
    end

    it "includes the size of the image" do
      subject[0,8].unpack("SS").must_be :==, [8,8]
    end

    it "encodes the body of the image" do
      subject[4..-1].unpack("C*").must_be :==, [128,64,32,16,8,4,2,1]
    end

    it "rotates the image so the bottom is printed first" do
      data = Jobs::ImageToBytes.encoded_image(fixture_path("8x8-top.png"))
      data[4..-1].unpack("C*").must_be :==, [0,0,0,0,0,0,0,6]
    end
  end

  describe "performing" do
    it "puts the data into the printer" do
      data = "blah"
      Jobs::ImageToBytes.stubs(:encoded_image).with("file_path").returns(data)
      Printer.stubs(:new).with("id").returns(printer = stub("printer"))
      printer.expects(:add_print_data).with(data)
      Jobs::ImageToBytes.perform("file_path", "id")
    end
  end
end