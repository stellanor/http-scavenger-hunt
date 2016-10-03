require_relative '../spec_helper'

describe "Flags Controller" do
  context "flag creation" do
    context "with cookie" do
      it "plants the flag" do
        u = User.create(username: "foo", password: "bar")
        header("Cookie", "user_id=#{u.id}")
        expect{post flags_path}.to change{Flag.count}.by(1)
        expect(Flag.last.user).to eq(u)
        expect(last_response).to be_ok
      end
    end

    context "without cookie" do
      it "responds with 401" do
        expect{post flags_path}.to_not change{Flag.count}
        expect(last_response.status).to eq(401)
      end
    end
  end

  context "flag listing" do
    it "lists the flags planted" do
      get flags_path
      expect(last_response).to be_ok
    end
  end
end
