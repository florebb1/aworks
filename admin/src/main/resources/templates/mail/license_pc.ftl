<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=0">
    <title>mailform_password</title>
</head>
<body style="height:100%;margin:0;background-color:#f8f8f8;">
<table width="100%" cellspacing="0" cellpadding="0">
    <tr>
        <td style="padding-top:30px;">
            <table width="100%" cellpadding="0" cellspacing="0" style="background-color:#fff;margin:0 auto;width:600px;border:1px solid #dddddd;">
                <tr>
                    <td style="text-align:center;background-color:#00a2ad;padding:30px 20px 25px 20px;">
                        <img src="http://aworksrpa.com/uploads/logo.png">
                    </td>
                </tr>
                <tr>
                    <td style="font-size:24px;font-weight:bold;color:#545454;padding:40px 40px 30px 40px;">
                        A.WORKS 라이선스 발급
                    </td>
                </tr>
                <tr>
                    <td style="font-size:18px;font-weight:500;color:#8d8d8d;padding:0 40px 40px;line-height:220%;">
                        안녕하세요 <br>라이선스가 발급되었습니다.<br>라이선스 입력 창에 아래 코드 또는 첨부파일을 확인하여 입력 해주시기 바랍니다.<br>감사합니다.
                    </td>
                </tr>
                <tr>
                    <td style="padding:0 40px 40px 40px;">
                        <div style="border:3px dotted #d5e6e5;text-align:center;padding:35px;font-weight:900;font-size:24px;color:#313131;">
                            <div style="width:280px;background-color:#ffffff;margin:-48px auto 0;font-size:18px;">라이선스 정보</div>
                            <div style="padding-top:28px;">${license!}</div>
                        </div>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <#--<p style="width: 100%; text-align: center; font-size: 12px; color: #9b9b9b;">ⓒ2019 a.works. All rights reserved.</p>-->
        </td>
    </tr>
</table>

</body>
</html>