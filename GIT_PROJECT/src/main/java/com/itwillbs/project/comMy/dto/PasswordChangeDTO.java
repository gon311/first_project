package com.itwillbs.project.comMy.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class PasswordChangeDTO {
    private String currentPassword;
    private String newPassword;
    private String newPasswordConfirm;
    private String captcha; // 쓰면 사용
}

