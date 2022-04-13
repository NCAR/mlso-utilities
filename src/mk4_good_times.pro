; docformat = 'rst'


pro mk4_good_times_print_date, lun, date
  compile_opt strictarr

  year = strmid(date, 0, 4)
  month = strmid(date, 4, 2)
  day = strmid(date, 6, 2)

  hours = strmid(date, 9, 2)
  minutes = strmid(date, 11, 2)
  seconds = strmid(date, 13, 2)

  printf, lun, year, month, day, hours, minutes, seconds, $
         format='(%"%s %s %s %s %s %s")'
end


pro mk4_good_times_add_date, root_dir, date, lun
  compile_opt strictarr

  year = strmid(date, 0, 4)
  month = strmid(date, 4, 2)
  day = strmid(date, 6, 2)

  files = file_search(filepath('*mk4*.fts*', subdir=[year, month, day], root=root_dir), $
                      count=n_files)
  print, n_files, format='(%"%d files")'
  if (n_files gt 0L) then begin
    dts = strmid(file_basename(files), 0, 15)
    uniq_dts = dts[uniq(dts, sort(dts))]
    for d = 0L, n_elements(uniq_dts) - 1L do begin
      mk4_good_times_print_date, lun, uniq_dts[d]
    endfor
  endif
end


function mk4_good_times_increment_date, date
  compile_opt strictarr

  year = long(strmid(date, 0, 4))
  month = long(strmid(date, 4, 2))
  day = long(strmid(date, 6, 2))

  jd = julday(month, day, year) + 1.0D
  caldat, jd, month, day, year

  return, string(year, month, day, format='(%"%04d%02d%02d")')
end


;+
; Find the date/times for all good Mk4 data.
;-
pro mk4_good_times, root_dir, start_date, end_date, output_filename=output_filename
  compile_opt strictarr

  date = start_date
  openw, lun, output_filename, /get_lun
  while (date ne end_date) do begin
    print, date
    mk4_good_times_add_date, root_dir, date, lun
    date = mk4_good_times_increment_date(date)
  endwhile
  free_lun, lun
end


; main-level example program


root_dir = '/hao/acos'
start_date = '19981028'
end_date = '20130720'
output_filename = 'mk4_good_times.txt'
mk4_good_times, root_dir, start_date, end_date, output_filename=output_filename

end
