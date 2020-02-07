; docformat = 'rst'

pro hao_db_query, start_date, end_date, config_filename, config_section
  compile_opt strictarr

  db = mgdbmysql()
  db->connect, config_filename=config_filename, $
               config_section=config_section

  query = 'select * from HAO.hao_download where date between ''%s'' and ''%s'''
  downloads = db->query(query, start_date, end_date)

  total_download_size = total(downloads.tot_filesize, /integer)
  print, 'total size of data delivers to users', $
         mg_human_size(total_download_size), $
         format='(%"%-40s: %s")'

  unique_user_id_indices = uniq(downloads.user_id, sort(downloads.user_id))
  user_ids = downloads.user_id
  unique_user_ids = user_ids[unique_user_id_indices]
  print, '# of unique user IDs', n_elements(unique_user_ids), $
         format='(%"%-40s: %d")'

  query = 'select * from HAO.hao_institution where institution like ''%%NCAR%%'''
  ncar_institutions = db->query(query)
  ncar_ids = ncar_institutions.institution_id

  query = 'select * from HAO.hao_user where user_id=%d'
  n_non_ncar_users = 0L
  for u = 0, n_elements(unique_user_ids) - 1L do begin
    user = db->query(query, unique_user_ids[u], sql_statement=cmd)
    if (~mg_in(ncar_ids, user.institution)) then n_non_ncar_users += 1L
  endfor

  ;4. Number of unique non-NCAR users
  print, '# of non-NCAR unqiue users', n_non_ncar_users, $
         format='(%"%-40s: %d")'

  if (obj_valid(db)) then obj_destroy, db
end


; main-level example program

hao_db_query, '2019-01-01', '2020-01-01', '~/.mysqldb', 'mgalloy@databases'

end
