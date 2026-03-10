package com.itwillbs.project.user.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class NewPasswordDTO {
	private String currentPassword;
    private String newPassword;
    private String newPasswordConfirm;
    private String captcha;
}

