require_relative '../spec_helper'

describe "Levels Controller" do
  context "level 1" do
    it "respond with 200" do
      get level_path(1)
      expect(last_response).to be_ok
    end
  end

  context "level 2" do
    it "respond with 200" do
      get level_path(2)
      expect(last_response).to be_ok
    end
  end

  context "level 3" do
    context "with secret" do
      it "respond with 200" do
        get level_path(3)+"?secret=#{LevelNames::LEVEL_3_SECRET}"
        expect(last_response).to be_ok
      end
    end

    context "without secret" do
      it "responds with 403" do
        get level_path(3)
        expect(last_response.status).to eq(403)
      end
    end
  end

  context "level 4" do
    it "redirects" do
      get level_path(4)
      expect(last_response.status).to eq(301)
      expect(last_response.headers["Location"])
        .to eq(level_path(5))
    end
  end

  context "level 5" do
    it "respond with 200" do
      get level_path(5)
      expect(last_response).to be_ok
    end
  end

  context "level 6" do
    it "respond with 200" do
      get level_path(6)
      expect(last_response).to be_ok
    end
  end

  context "with a user agent" do
    LevelNames::LEVEL_PATHS.each do |path|
      it "#{path} 400s if user agent is present" do
        header("User-Agent", "Foo")
        get path
        expect(last_response).to_not be_ok
      end
    end
  end
end