require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it 'nickname,email,password,password_confirmation,last_name,first_name,last_name_kana,first_name_kana,birthdayが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'emailに@が含まれていれば登録できる' do
        @user.email = "test@test"
        expect(@user).to be_valid
      end
      it 'passwordが6文字以上の半角英数字であれば登録できる' do
        @user.password = "pass12"
        @user.password_confirmation = "pass12"
        expect(@user).to be_valid
      end
      it 'last_nameが全角漢字・かな・カナであれば登録できる' do
        @user.last_name = "山田"
        expect(@user).to be_valid
      end
      it 'first_nameが全角漢字・かな・カナであれば登録できる' do
        @user.first_name = "陸たロウ"
        expect(@user).to be_valid
      end
      it 'last_name_kanaが全角カナであれば登録できる' do
        @user.last_name_kana = "ヤマダ"
        expect(@user).to be_valid
      end
      it 'first_name_kanaが全角カナであれば登録できる' do
        @user.first_name_kana = "リクタロウ"
        expect(@user).to be_valid
      end
    end
    context '新規登録がうまくいかないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'emailが他のユーザーと重複すると登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it 'emailに@が含まれていないと登録できない' do
        @user.email = 'test.test'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = 000000
        @user.password_confirmation = 000000
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it 'passwordが半角英数字混合以外では登録できない' do
        @user.password = 123456
        @user.password_confirmation = 123456
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
      end
      it 'passwordが確認用も含めて2回入力しないと登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordとpassword_confirmationが一致していないと登録できない' do
        @user.password = "pass123"
        @user.password_confirmation = "pass1234"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordが全角のみだと登録できない' do
        @user.password = "ＰＡＳＳ１２３"
        @user.password_confirmation = "ＰＡＳＳ１２３"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
      end
      it 'passwordが半角英字のみだと登録できない' do
        @user.password = "passpass"
        @user.password_confirmation = "passpass"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
      end
      it 'last_nameが漢字・ひらがな・カタカナ以外では登録できない' do
        @user.last_name = "ＹＡＭＡＤＡ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid. Input full-width characters")
      end
      it 'first_nameが漢字・ひらがな・カタカナ以外では登録できない' do
        @user.first_name = "ＲＩＫＵＴＡＲＯ"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid. Input full-width characters")
      end
      it 'last_name_kanaが全角カタカナ以外では登録できない' do
        @user.last_name_kana = "ﾔﾏﾀﾞ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid. Input full-width katakana characters")
      end
      it 'first_name_kanaが全角カタカナ以外では登録できない' do
        @user.first_name_kana = "ﾘｸﾀﾛｳ"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid. Input full-width katakana characters")
      end
    end
  end
end
