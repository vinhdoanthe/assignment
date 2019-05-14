$(document).ready(function () {
    $('#grade_form').on("submit", function (event) {
        event.preventDefault();
        var data = $(this).serializeJSON();
        alert(JSON.stringify(data))
        validate(data);
    });

    function validate(data) {
        var criteriums = data['graded_rubric']['graded_criteriums_attributes']
        var criterium
        for (criterium in criteriums) {
            if (criteriums[criterium.toString()]['status'] == 'not graded') {
                alert('Criteria ' + criterium + ' is not graded. Please grade it')
            }
        }
    }
})