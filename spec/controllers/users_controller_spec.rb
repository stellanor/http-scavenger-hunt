require_relative '../spec_helper'

describe "Users Controller" do
  context "user creation" do
    context "with valid params" do
      let(:params) { {username: "test", password: "123"} }
      it "responds with 200" do
        post user_create_path, params
        expect(last_response).to be_ok
      end

      it "creates a user" do
        expect {post user_create_path, params}
          .to change{User.count}.by(1)
      end
    end

    context "with invalid params" do
      let(:params) { {username: "test"} }

      it "responds with 400" do
        post user_create_path, params
        expect(last_response.status).to eq(422)
      end

      it "does not create a user" do
        expect {post user_create_path, params}
          .to_not change{User.count}
      end
    end
  end

  context "user login" do
    let(:params) { {username: "test", password: "123"} }

    context "with valid credentials" do
      before :each do
        expect(User).to receive(:find_by)
          .with(params)
          .and_return(double(id: 101))
      end

      it "should set a cookie" do
        post user_login_path, params
        expect(last_response.headers["Set-Cookie"])
          .to eq("user_id=101")
      end

      it "should redirect to the profile" do
        post user_login_path, params
        expect(last_response.status).to eq(301)
        expect(last_response.headers["Location"])
          .to eq(user_profile_path)
      end
    end

    context "with invalid credentials" do
      before :each do
        expect(User).to receive(:find_by)
          .with(params)
          .and_return(nil)
      end

      it "should not set a cookie" do
        post user_login_path, params
        expect(last_response.headers["Set-Cookie"])
          .to be(nil)
        expect(last_response).to_not be_ok
      end
    end
  end

  context "user profile" do
    context "with cookie" do
      it "responds with 200" do
        uid = "1"
        user = double(username: "foo")

        expect(User).to receive(:find_by)
          .with(id: uid)
          .and_return(user)

        header("Cookie", "user_id=#{uid}")
        get user_profile_path
        expect(last_response).to be_ok
      end
    end

    context "without cookie" do
      it "responds with 401" do
        expect(User).to receive(:find_by)
          .with(id: nil)

        get user_profile_path
        expect(last_response.status).to eq(401)
      end
    end
  end
end
