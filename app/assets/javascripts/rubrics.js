$(function () {
    $('#rubric_course_instance').change(function () {
        var course_instance_id = $(this).val();
        if (course_instance_id == "") {
            // Do nothing
        } else {
            $.ajax({
                dataType: "json",
                url: "/get_assignments_by_course_instance/" + course_instance_id,
                cache: false,
                error: function (xhr, status, error) {
                    console.log('AJAX error:' + status + error);
                },
                success: function (data) {
                    console.log(data)
                    $("select#rubric_assignment_id option").remove();
                    $.each(data, function (i, j) {
                        row = "<option value=\"" + j.id + "\">" + j.name + "</option>";
                        $(row).appendTo("select#rubric_assignment_id");
                    });
                }
            })
        }
    })
})