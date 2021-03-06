<form id="form-rkpd" class="form-horizontal" role="form" method="POST" action="{{ Request::url() }}">
{{ csrf_field() }}

<div class="row">
    <div class="col-md-6">
        <div class="form-group{{ $errors->has('tahun_rkpd') ? ' has-error' : '' }}">
            <label for="email" class="col-md-4">Tahun</label>
            <div class="col-md-8">
                <select id="tahun_rkpd" type="tahun_rkpd" class="form-control" name="tahun_rkpd" value="{{ isset($model['tahun_rkpd']) ? $model['tahun_rkpd'] : '' }}" required>
                    <option value={{ $rpjmdDokumen->tahun_1 }}>{{ $rpjmdDokumen->tahun_1 }}</option>
                    <option value={{ $rpjmdDokumen->tahun_2 }}>{{ $rpjmdDokumen->tahun_2 }}</option>
                    <option value={{ $rpjmdDokumen->tahun_3 }}>{{ $rpjmdDokumen->tahun_3 }}</option>
                    <option value={{ $rpjmdDokumen->tahun_4 }}>{{ $rpjmdDokumen->tahun_4 }}</option>
                    <option value={{ $rpjmdDokumen->tahun_5 }}>{{ $rpjmdDokumen->tahun_5 }}</option>
                </select>                            
                @if ($errors->has('tahun_rkpd'))
                    <span class="help-block">
                        <strong>{{ $errors->first('tahun_rkpd') }}</strong>
                    </span>
                @endif
            </div>
        </div>
    </div><!--column-->
    <div class="col-md-6">
        <div class="form-group{{ $errors->has('no_urut') ? ' has-error' : '' }}">
            <label for="name" class="col-md-4">No Urut</label>

            <div class="col-md-8">
                <input id="no_urut" type="text" class="form-control" name="no_urut" value="{{ isset($model['no_urut']) ? $model['no_urut'] : '' }}">

                @if ($errors->has('no_urut'))
                    <span class="help-block">
                        <strong>{{ $errors->first('no_urut') }}</strong>
                    </span>
                @endif
            </div>
        </div>    
    </div><!--column-->
</div><!--row-->

<div class="row">
    <div class="col-md-12">
        <div class="form-group{{ $errors->has('id_program_rpjmd') ? ' has-error' : '' }}">
            <label for="name" class="col-md-2">Id Program</label>

            <div class="col-md-10">
                <input id="id_program_rpjmd" type="text" class="form-control" name="id_program_rpjmd" value="{{ isset($model['id_program_rpjmd']) ? $model['id_program_rpjmd'] : '' }}">

                @if ($errors->has('id_program_rpjmd'))
                    <span class="help-block">
                        <strong>{{ $errors->first('id_program_rpjmd') }}</strong>
                    </span>
                @endif
            </div>
        </div>     
    </div><!--column-->
</div><!--row-->

<div class="row">
    <div class="col-md-12">
        <div class="form-group{{ $errors->has('uraian_program_rpjmd') ? ' has-error' : '' }}">
            <label for="name" class="col-md-2">Uraian Program</label>

            <div class="col-md-10">
                <input id="uraian_program_rpjmd" type="text" class="form-control" name="uraian_program_rpjmd" value="{{ isset($model['uraian_program_rpjmd']) ? $model['uraian_program_rpjmd'] : '' }}">

                @if ($errors->has('uraian_program_rpjmd'))
                    <span class="help-block">
                        <strong>{{ $errors->first('uraian_program_rpjmd') }}</strong>
                    </span>
                @endif
            </div>
        </div>     
    </div><!--column-->
</div><!--row-->

<div class="row">
    <div class="col-md-6">
        <div class="form-group{{ $errors->has('pagu_program_rpjmd') ? ' has-error' : '' }}">
            <label for="name" class="col-md-4">Pagu</label>

            <div class="col-md-8">
                <input id="pagu_program_rpjmd" type="text" class="form-control" name="pagu_program_rpjmd" value="{{ isset($model['pagu_program_rpjmd']) ? $model['pagu_program_rpjmd'] : '' }}">

                @if ($errors->has('pagu_program_rpjmd'))
                    <span class="help-block">
                        <strong>{{ $errors->first('pagu_program_rpjmd') }}</strong>
                    </span>
                @endif
            </div>
        </div>    
    </div><!--column-->
</div><!--row-->

<div class="form-group">
    <div class="col-md-6 col-md-offset-4">
        <button type="submit" class="btn btn-primary">
            Simpan
        </button>
    </div>
</div>

</form>

<script>
    $('form#form-rkpd').on('beforeSubmit',function(e)
    {
        var form = $(this);
        $.post(
            form.attr("action"), //serialize Yii2 form 
            form.serialize()
        )
            .done(function(result){
                if(result == 1)
                {
                    $("#myModal").modal('hide'); //hide modal after submit
                    //$(\$form).trigger("reset"); //reset form to reuse it to input
                    // $.pjax.reload({container:'#ta-baver-pjax'});
                    $('#ranwal-table').DataTable().ajax.reload();
                }else
                {
                    $("#message").html(result);
                }
            }).fail(function(){
                console.log("server error");
            });
        e.preventDefault();
        return false;

        // another method
        // $.ajaxSetup({
        // headers: { 'X-CSRF-Token' : $('meta[name=_token]').attr('content') }
        // });

        // $.ajax({
        //     type: 'post',
        //     url: '{{ Request::url() }}',
        //     data: {
        //         \$form.attr("action"), \$form.serialize()
        //     },
        //     success: function(data) {
        //         if ((data.errors)){
        //         $('.error').removeClass('hidden');
        //             $('.error').text(data.errors.name1);
        //         }
        //         else {
        //             $('.error').addClass('hidden');
        //             $('#ranwal-table').DataTable().ajax.reload();
        //         }
        //     },
        // });

        // $('#ranwal-table').DataTable().ajax.reload();        
    });    
</script>