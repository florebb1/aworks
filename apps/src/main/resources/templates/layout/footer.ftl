</div>

<section class="footer">
    <div class="container h-100">
        <div class="row h-100">
            <div class="col-auto d-flex flex-column justify-content-center align-items-start">
                <div class="mt-3">
                    <a href="/info/about"><@spring.message "footer.text1"/></a>
                    <span>ㅣ</span>
                    <a href="/info/terms"><@spring.message "footer.text2"/></a>
                    <span>ㅣ</span>
                    <a href="/info/privacy"><@spring.message "footer.text3"/></a>
                    <span>ㅣ</span>
                    <a><@spring.message "footer.text4"/></a>
                </div>
                <div class="info-adress mt-4"><@spring.message "footer.text5"/></div>
                <div class="info-adress mt-2"><@spring.message "footer.text6"/> · <@spring.message "footer.text7"/> · <@spring.message "footer.text8"/> · <@spring.message "footer.text9"/></div>
                <div class="copyright mt-1">ⓒ2019 a.works. All rights resevers.</div>
            </div>
            <div class="col d-flex flex-column justify-content-center align-items-end">
                <div class="sns-link">
                    <a href="https://www.facebook.com/" target="_blank"><i class="icon-facebook-logo-button font24"></i></a>
                    <a href="https://www.instagram.com/" target="_blank"><i class="icon-instagram font24"></i></a>
                    <a href="https://www.youtube.com/" target="_blank"><i class="icon-youtube-symbol font24"></i></a>
                </div>
                <div class="mt-2">
                    <select onChange="window.open(this.value)" class="form-control family-link-select btn-border-none btn-border-radius-none">
                        <option>Family Site</option>
                        <option value="https://www.poscoict.com/"><@spring.message "footer.text10"/></option>
                        <option value="http://www.posco.co.kr/"><@spring.message "footer.text11"/></option>
                        <option value="http://www.poscointl.com/"><@spring.message "footer.text12"/></option>
                    </select>
                </div>
            </div>
        </div>
    </div>
</section>
</body>

</html>
