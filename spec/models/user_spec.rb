require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    it 'ニックネームが空では登録できない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("ニックネームを入力してください")
    end
    it 'メールアドレスが空では登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("メールアドレスを入力してください")
    end
    it 'メールアドレスが他のユーザーと重複すると登録できない' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include("メールアドレスはすでに存在します")
    end
    it 'メールアドレスに@が含まれていないと登録できない' do
      @user.email = 'test.test'
      @user.valid?
      expect(@user.errors.full_messages).to include("メールアドレスは不正な値です")
    end
    it 'パスワードが空では登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードを入力してください")
    end
    it 'パスワードが5文字以下では登録できない' do
      @user.password = 000000
      @user.password_confirmation = 000000
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
    end
    it 'パスワードが半角英数字混合以外では登録できない' do
      @user.password = 123456
      @user.password_confirmation = 123456
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードには英字と数字の両方を含めて設定してください")
    end
    it 'パスワードが確認用も含めて2回入力しないと登録できない' do
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワード(確認)とパスワードの入力が一致しません")
    end
    it 'パスワードとパスワード(確認)が一致していないと登録できない' do
      @user.password = "pass123"
      @user.password_confirmation = "pass1234"
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワード(確認)とパスワードの入力が一致しません")
    end
  end
end
