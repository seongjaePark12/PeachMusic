package com.PSJ.PSJMusic;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/mail")
public class MailController {
	@Autowired
	JavaMailSender mailSender;
	
	// 임시비밀번호 발급해서 메일로보냄
	@RequestMapping(value="/pwdConfirmSend/{email}/{content}/", method = RequestMethod.GET)
	public String pwdConfirmSendGet(@PathVariable String email, @PathVariable String content) {
		try {
			String fromMail = "LouisVuittonPSJ@gmail.com";
			String title = ">>임시 비밀번호를 발급 하였습니다<<";
			String pwd = content;
			content = "피치뮤직에서 발송한 매일입니다.\n 아래 임시 비밀번호를 보내오니 사이트에 접속 하셔서 비밀번호를 변경하세요 \n";
			
			// 메세지를 변환시켜서 보관함에 저장하기위한 준비를 한다
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		
			// 메일 보관함에 회원이 보낸 메세지를 모두 저장시켜준다
			messageHelper.setFrom(fromMail);
			messageHelper.setTo(email);
			messageHelper.setSubject(title);
			
			// 메세지 내용 편집 후 보관함에 저장처리한다
			content = content.replace("\n", "<br>");
			content += "<br><div><img src=\"cid:logo.png\" width='300px' align='center'/></div><br><br>";
			content += "<div>임시 비밀번호가 발급 되었습니다.</div>";
			content += "<br><hr><h3>임시 비밀번호 : <font color='red'>"+pwd+"</font></h3><hr><br>";
			content += "<div>고객님의 비밀번호가 변경되었습니다.</div>";
			content += "<div>임시 비밀번호로 로그인 후 수정해주세요</div>";
			content += "</div>";
			messageHelper.setText(content, true);
			FileSystemResource file = new FileSystemResource("C:\\Users\\박성재\\git\\repository8\\PSJMusic\\src\\main\\webapp\\resources\\images\\title\\logo.png");
			messageHelper.addInline("logo.png", file);
			
			mailSender.send(message);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		
		return "redirect:/msg/pwdConfirmOk";
	}

}
