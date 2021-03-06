<?php
use hoaaah\LaravelBreadcrumb\Breadcrumb as Breadcrumb;
?>

@extends('layouts.app')


@section('content')
<div class="container">
    <div class="row">
        <div class="col-md-10">
            <?php
                $this->title = $title[0];
                $breadcrumb = new Breadcrumb();
                $breadcrumb->homeUrl = 'modul2';
                $breadcrumb->begin();
                $breadcrumb->add(['label' => 'RKPD']);
                $breadcrumb->add(['url' => '/rahirrkpd', 'label' => 'Rancangan Akhir RKPD']);
                $breadcrumb->add(['label' => $this->title]);
                $breadcrumb->end();
            ?>          
        </div>
    </div>

    <div class="row">
        <div class="col-md-10">
            <!-- Left Sideways Bordered -->
            <div class='tabs-x tabs-above tab-bordered tabs-krajee'>
                <ul id="myTab-19" class="nav nav-tabs" role="tablist">
                    <li id="tab-home" class="active"><a id="link-home" href="#home" role="tab" data-toggle="tab"><i class="glyphicon glyphicon-home"></i> Kegiatan</a></li>
                    <li id="tab-pelaksana"><a href="#pelaksana" role="tab-kv" data-toggle="tab">Kebijakan - Pelaksana - Indikator</a></li>
                    <li id="tab-belanja"><a href="#belanja" role="tab-kv" data-toggle="tab">Belanja</a></li>
                </ul>
                <div id="myTabContent-19" class="tab-content">
                    <div class="tab-pane fade" id="program"><p>...</p></div>
                    <!-- tab home content-->
                    <div class="tab-pane fade in active" id="home">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h2 class="panel-title">Daftar Usulan Rancangan Awal Renja - {{ $title[0] }}</h2>
                            </div>
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <!--<a class="btn btn-primary btn-xs" href="#" data-href="{{ url('/renja/'.$title[1].'/tambah') }}" data-toggle="modal" data-target="#myModal" data-title="Tambah Program RKPD"><i class="glyphicon glyphicon-plus bg-white"></i> Tambah</a>-->
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <table id="renja-table" class="table table-striped table-bordered table-responsive">
                                            <thead>
                                                <tr>
                                                    <th style="text-align: center; vertical-align:middle">No Urut</th>
                                                    <th style="text-align: center; vertical-align:middle">Kode</th>
                                                    <th style="text-align: center; vertical-align:middle">Uraian Kegiatan</th>
                                                    <th style="text-align: center; vertical-align:middle">Pagu Kegiatan</th>
                                                    <th style="text-align: center; vertical-align:middle">Aksi</th>
                                                </tr>
                                            </thead>
                                        </table>   
                                    </div>
                                </div>
                            </div>
                        </div>                    
                    </div>
                    <!-- tab pelaksana content-->
                    <div class="tab-pane fade" id="pelaksana"><p>...</p></div>
                    <!-- tab belanja content-->
                    <div class="tab-pane fade" id="belanja"><p>...</p></div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection

@section('scripts')
<script>
    $(document).ready(function(){    
        // ajax for datatables
        $(function() {
            $('#renja-table').DataTable({
                processing: true,
                serverSide: true,
                ajax: '{{ Request::url() }}',
                columns: [
                    { data: 'no_urut', name: 'no_urut' },
                    { data: 'id_kegiatan_renstra', name: 'id_kegiatan_renstra' },
                    { data: 'uraian_kegiatan_renstra', name: 'uraian_kegiatan_renstra' },
                    { 
                        data: 'pagu_tahun_kegiatan', 
                        name: 'pagu_tahun_kegiatan',
                        render: $.fn.dataTable.render.number( '.', ',', 0, 'Rp' ),
                        sClass: "dt-right" 
                    },
                    { data: 'action', name: 'action', orderable: false, searchable: false }
                ],
                aoColumnDefs: [
                    { sClass: "dt-center", aTargets: [ 0, 1 ] },
                    // { 
                    //     'render': function ( data, type, row, meta ) {
                    //         if(data == 'onsale_c') { 
                    //             return 'On-Sale Common'
                    //         }
                    //     }, 
                    //     aTargets: [ 4 ] 
                    // },
                ],
                createdRow: function( row, data, dataIndex ) {
                    $(row).attr('data-id', data.id_rkpd_rancangan);
                },
                fnRowCallback: function(nRow, aData, iDisplayIndex, iDisplayIndexFull){
                    var ajaxPelaksana = function(){
                        
                    }
                    $('#renja-table tbody').on('dblclick', 'tr', function(e){
                        var id = $(this).closest('tr').data('id');
                        var target = e.target
                        var link = '{{ $title[1] }}/'
                        // console.log(id)
                        // console.log(this)
                        // console.log(e.target)
                        if(e.target == target){ //actually, we should check if e.target == this. But after I checked it, this method didn't work, and I dunno why
                            var href = '{{ url('/rancanganrkpd/') }}/' + link + id + '/pelaksana';
                            $('#tab-home').removeClass('active');
                            // $('#tab-home').attr('class', 'disabled');
                            $('#tab-home').html('<a href=\"#home\"  data-toggle=\"tab\" role=\"tab\" title=\"program\"><i class=\"glyphicon glyphicon-home\"></i> Kegiatan</a>');
                            $('#tab-pelaksana').attr('class', 'active');

                            $('#link-home').click();
                            $('#home').removeClass('active in');
                            $('#pelaksana').addClass('active in');
                            $('#pelaksana').html('<i class=\"fa fa-spinner fa-spin\"></i>');
                            $.get(href).done(function(data){
                                $('#pelaksana').html(data);
                                // console.log('voila pelaksana');
                            });
                        }
                    });
                    $('#renja-table tbody').on('click', 'a', function(e){
                        var id = $(this).attr('id')
                        var target = e.target;
                        if(id) var id = id.split('-');
                        if(typeof id !== 'undefined' && id[0] == 'rincian'){
                            var href = $(this).data('href');
                            if(e.target == target){ //actually, we should check if e.target == this. But after I checked it, this method didn't work, and I dunno why
                                // var href = '{{ url('/ranwalrkpd/btl/') }}/' + id + '/pelaksana';
                                $('#tab-home').removeClass('active');
                                // $('#tab-home').attr('class', 'disabled');
                                $('#tab-home').html('<a href=\"#home\"  data-toggle=\"tab\" role=\"tab\" title=\"program\"><i class=\"glyphicon glyphicon-home\"></i> Kegiatan</a>');
                                $('#tab-pelaksana').attr('class', 'active');

                                $('#link-home').click();
                                $('#home').removeClass('active in');
                                $('#pelaksana').addClass('active in');
                                $('#pelaksana').html('<i class=\"fa fa-spinner fa-spin\"></i>');
                                $.get(href).done(function(data){
                                    $('#pelaksana').html(data);
                                    // console.log('voila pelaksana');
                                });
                            }
                        }
                    });                    
                                                            
                }
            });
        });

        //ajax for modaledit
        $('#myModal').on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget);
            var modal = $(this);
            var title = button.data('title');
            var href = button.attr('href');
            href = button.data('href');
            modal.find('.modal-title').text(title);
            modal.find('.modal-body').html('<i class="fa fa-spinner fa-spin"></i>');
            $.get(href, function( data ) {
                modal.find(".modal-body").html(data);
            });
        })           
    });
</script>
@endsection

<!-- Modal Group -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Title</h4>
      </div>
      <div class="modal-body">
            ....
      </div>
    </div>
  </div>
</div>