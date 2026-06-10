<?php $this->load->view('peserta/layout/header'); ?>
<?php $this->load->view('peserta/layout/sidebar'); ?>

<div class="container-fluid">

<?php if($logbook->status != 'ditolak' && $logbook->status != 'menunggu'): ?>

    <div class="alert alert-danger">
        Terkunci - Logbook sudah diproses admin.
    </div>

<?php else: ?>

<div class="card shadow-sm mb-4">
    <div class="card-body">

        <h5 class="mb-3">Edit Logbook Kegiatan Magang</h5>

        <form action="<?= base_url('logbook/update') ?>" method="post">

            <input type="hidden" name="id" value="<?= $logbook->id ?>">

            <div class="row">

                <div class="col-md-3">
                    <label class="form-label">Tanggal</label>
                    <input
                        type="date"
                        name="tanggal"
                        class="form-control"
                        value="<?= $logbook->tanggal ?>"
                        required>
                </div>

                <div class="col-md-4">
                    <label class="form-label">Kegiatan</label>
                    <input
                        type="text"
                        name="kegiatan"
                        class="form-control"
                        value="<?= $logbook->kegiatan ?>"
                        required>
                </div>

                <div class="col-md-5">
                    <label class="form-label">Deskripsi</label>
                    <textarea
                        name="deskripsi"
                        class="form-control"
                        rows="3"
                        required><?= $logbook->deskripsi ?></textarea>
                </div>

            </div>

            <div class="mt-3">

                <button type="submit" class="btn btn-primary">
                    Update Logbook
                </button>

                <a href="<?= base_url('logbook') ?>" class="btn btn-secondary">
                    Kembali
                </a>

            </div>

        </form>

    </div>
</div>

<?php endif; ?>

</div>

<?php $this->load->view('peserta/layout/footer'); ?>