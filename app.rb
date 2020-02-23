#encoding: utf-8
require 'rubygems'
require 'sinatra'
#require 'sinatra/reloader'

get '/' do
    erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"
end

get '/about' do
    @error = "somephing wrong!"    # Пример вывода ошибки
    erb :about
end

get '/visit' do
    erb :visit
end

post '/visit' do

    @user_name = params[:user_name]
    @phone     = params[:phone]
    @date_time = params[:date_time]
    @barber    = params[:barber]
    @color     = params[:colorpicker]

    hh = {  :user_name => 'Введите имя ',
                :phone => 'Введите номер телефона ',
            :date_time => 'Введите дату и время ' }
=begin
    # Для каждой пары ключ-значение
    hh.each do |key, value|
        # если параметр пуст
        if params[key] == ''
            # переменной error присвоить союе value из хеша hh
            # т.е переменной error присвоить сообщение об ошибке
            @error = hh[key]
        end
        return erb :visit
    end
=end
    @error = hh.select {|key,_| params[key] == ""}.values.join(",")
    return erb :visit if @error != ''
    
    @title = 'Спасибо!'
    @message = "Спасибо вам, #{@user_name}, будем ждать Вас."

    out_f = File.open './public/users.txt', 'a'
    out_f.write "User: #{@user_name}, Phone: #{@phone},"
    out_f.write " Date_Time: #{@date_time} Barber: #{@barber}\n"
    out_f.close

    erb :message
end

get '/contacts' do
    erb :contacts
end

post '/contacts' do
    @user_name      = params[:user_name]
    @phone_mail     = params[:phone_mail]
    @message_user   = params[:message_user]

    @title = 'Ваше обращение доставлено!'
    @message = "Спасибо за обращение. Если оно требует ответа, мы постараемся связаться с Вами в бижайшее время."

    out_f = File.open './public/contacts.txt', 'a'
    out_f.write "\n\nUser: #{@user_name}, Call: #{@phone_mail},\n"
    out_f.write "Message: #{@message_user}\n"
    out_f.close

    erb :message
end

