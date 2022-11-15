duties = %w(代表 副代表 会計係 ユニフォーム係 ボール係 合宿係 試合係 入退部係 イベント係)
duties.each do |d|
  Duty.create(
    member_id: 1,
    role: d
  )
end