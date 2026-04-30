drop trigger if exists tgr_personale_maggiorenne;

delimiter $$
create trigger tgr_personale_maggiorenne before insert on personale
for each row
begin

if(NEW.data_nascita > date_sub(curdate(), interval 18 year))
then signal sqlstate '45000' set message_text = 'Il personale deve avere almeno 18 anni';
end if;

end 
$$
