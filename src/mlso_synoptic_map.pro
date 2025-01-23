; docformat = 'rst'

;+
; :Params:
;   filename : in, required, type=string
;     filename to write synoptic map
;   data : in, required, type="fltarr(nx, ny, n_images)"
;     data for the synoptic maps where columns correspond to the date/times in
;     `times` array
;   times : in, required, type="dblarr(n_images)"
;     times of the images in Julian dates
;
; :Keywords:
;   cadence : in, optional, type=integer, default=24
;     images per day
;-
pro mlso_synoptic_map, filename, data, times, $
                       start_time=start_time, end_time=end_time, $
                       bins=bins, $
                       cadence=cadence
  compile_opt strictarr

  _cadence = n_elements(cadence) eq 0L ? 24L : cadence
  _start_time = n_elements(start_time) eq 0L ? times[0] : start_time
  _end_time = n_elements(end_time) eq 0L ? times[-1] : end_time

  n_dims = size(data, /n_dimensions)
  dims = size(data, /dimensions)

  ; time for a bin marks the left edge of the bin
  n_bins = long((end_time - start_time) * _cadence)
  bins = (end_time - start_time) * dblarr(n_bins) / (n_bins - 1L) + start_time

  map = fltarr(n_bins, dims[1]) + !values.f_nan

  for r = 0L, dims[1] - 1L do begin
    row = reform(data[*, r])
    gridded_row = interpol(row, times, bins)  ; use /NAN keyword?
    ; fix NaNs in gridded row
    map[*, r] = gridded_row
  endfor

  return, map
end


; main-level example program

start_date = '20200128'
end_date = '20200224'
radius = 1.12

data = kcor_collect_synoptic(start_date, end_date, radius=radius, times=time, run=run)

filename = string(radius, format='(%"kcor-synoptic-map-%0.2fR.gif")')
map = mlso_synoptic_map(filename, data, times, bins=bins, cadence=24L)

end
