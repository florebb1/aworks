<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=0">
    <title>mailform_password</title>
</head>
<#import "/spring.ftl" as spring />
<body style="height: 100%; margin: 0; background-color: #f8f8f8; ">
<table width="100%" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <#--<img src="https://s3.ap-northeast-2.amazonaws.com/republiq-starmate/Logo_formpage_dark.png">-->
        </td>
    </tr>
    <tr>
        <td>
            <table width="100%" cellpadding="0" cellspacing="0" style="background-color: #fff; padding-top: 39px; padding-left: 40px; padding-right: 40px; margin-top: 20px; width:700px">
                <tr>
                    <td style="font-size: 16px; font-weight: bold; color: #313131;">a.works 비밀번호 초기화 정보</td>
                </tr>
                <tr>
                    <td style="padding-top: 39px; font-size: 14px; font-weight: normal; color: #313131; line-height: 2;">안녕하세요. <br>회원님의 비밀번호가 다음과 같이 초기화 되었습니다.<br>해당 비밀번호로 로그인하시기 바랍니다.<br>감사합니다.</td>
                </tr>
                <tr>
                    <td style="padding-bottom: 83px;">
                        <div style="padding-top: 25px; padding-bottom: 40px; padding-left: 25px; padding-right: 25px;">
                            <p>비밀번호 초기화 정보</p>
                            <div style="border: 1px solid #e7ba5b; padding-top: 11px; padding-bottom: 11px; text-align: center;">${newPassword!}</div>
                            <#--<a href="${loginUrl!}" style="text-decoration: none; width: 100%; display: block; margin-top: 40px; text-align: center; background-color: #2cabe3; border-radius: 23px; padding-top: 11px; padding-bottom: 11px; color: #fff; font-size: 18px;">로그인 페이지 이동</a>-->
                        </div>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <#--<p style="width: 100%; text-align: center; font-size: 12px; color: #9b9b9b;">Copyright ⓒ 2019 REPUBLIQ. All rights reserved.</p>-->
        </td>
    </tr>
</table>

</body>
</html>