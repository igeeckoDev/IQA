<script type="text/javascript">
    var optionsPostIt = {
        classNamePrefix:   'bvalidator_postit_',
        offset:               {x:-29, y:-10},
        template:          '<div class="{errMsgClass}">{message}<div class="bvalidator_postit_pointer"><div class="bvalidator_postit_inner_pointer"></div></div></div>'
    };
    
    $(document).ready(function () {
        $('#myform').bValidator(optionsPostIt);
    });
</script>